From: j-keerthy@ti.com (J, KEERTHY)
Date: Mon, 11 Feb 2013 04:46:19 +0000
Subject: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
In-Reply-To: <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
Message-ID: <DC88CAD03C0052499C1907B327FC63229B9573@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Saturday, February 09, 2013 12:29 AM
> To: J, KEERTHY
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> 
> Hi Keerthy,
> 
> On Fri, 8 Feb 2013, Paul Walmsley wrote:
> 
> > On Fri, 8 Feb 2013, J, KEERTHY wrote:
> >
> > > Thanks for updating. Yes renaming the 'omap_clocks_register_links()
> > > Is fine. I had blindly followed the hwmod function naming
> convention.
> > > The new name makes sense.
> >
> > OK great.  BTW don't forget to cc the linux-arm-kernel mailing list
> for
> > all patches, otherwise we won't be able to merge the patches.  Taking
> care
> > of it now in this case.
> 
> Just noticed during final testing of this patch that it causes some
> problems
> with power management on OMAP4460: (see the suspend/resume messages)
> 

I understand that retention is broken from the logs.
I first tried seeing if the retention is working without the patch
And I see that even without the patch retention fails.

I am attaching the log.

I just want to confirm if the retention is working fine without
Applying the patch on mainline.

Top Commit ID: 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39
Defconfig: omap2plus_defconfig

Am I missing something here?

> http://www.pwsan.com/omap/testlogs/jk_clock_flags_cleanup_3.9/201302071
> 83613/pm/4460pandaes/4460pandaes_log.txt
> 
> Could you please take a look at this and see what happened?  I suspect
> that
> I screwed something up as I was rebasing the patch.  Unfortunately I
> don't
> have the time to debug it further.
> 
> 
> - Paul

Regards,
Keerthy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Omap4460_Panda_log_without_CK__cleanup
Type: application/octet-stream
Size: 15326 bytes
Desc: Omap4460_Panda_log_without_CK__cleanup
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130211/259d6ff4/attachment-0001.obj>
