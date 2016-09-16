From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 16 Sep 2016 07:52:50 +0200
Subject: v4.8-rc: GSM audio causes trouble
In-Reply-To: <20160915205142.GA6747@amd>
References: <20160915121755.GA5264@amd>
 <20160915205142.GA6747@amd>
Message-ID: <20160916055249.h7zw6hguvwwe2zwu@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 15, 2016 at 10:51:42PM +0200, Pavel Machek wrote:
> > I was trying to improve GSM call quality, and hit problems in
> > v4.8-rc. Sound only worked for a while, then I tried to kill
> > cmtspeech_ofono_test, and could not, not even with -9 and could not
> > even reboot.
> > 
> > I went back to v4.1 (ok, quite far, I see), and problems are gone.
> > 
> > Does it work for you? Any ideas what to try... besides bisect?
> 
> v4.7 is okay.
> 
> v4.8 with
> 
> git diff ..mini-v4.7 drivers/hsi/ | git apply
> 
> Seems to work ok.
> 
> Best regards,

hsi changes from 4.7 to 4.8 are basically runtime PM enablement.
Does 4.8 work for you with just 9c99e5e51988 reverted?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/e6cccda1/attachment-0001.sig>
