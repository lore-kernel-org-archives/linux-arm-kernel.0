From: michal.bachraty@gmail.com (Michal Bachraty)
Date: Fri, 18 Jan 2013 09:23:14 +0100
Subject: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if
 not defined in dt
In-Reply-To: <871udjlafn.fsf@dell.be.48ers.dk>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
 <loom.20130117T105358-639@post.gmane.org>
 <87a9s7lq09.fsf@dell.be.48ers.dk>
 <20130117174528.GM14149@atomide.com>
 <871udjlafn.fsf@dell.be.48ers.dk>
Message-ID: <CAAfrEwaDd5CU5fd2TbSD-8dMdOrCeC8f5LxPUGfqUsRs69BV+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 11:19 PM, Peter Korsgaard <jacmet@sunsite.dk> wrote:

> >>>>> "Tony" == Tony Lindgren <tony@atomide.com> writes:
>
> Hi,
>
>  >> The way I've handled it is similar to how it is done on atleast one
>  >> other arm subarchicture, see
>  >> arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()
>
>  Tony> Cool this seems like the cleanest way to deal with it so far. Can
>  Tony> you please resend with also linux-net and DT list Cc:d too?
>
>  Tony> Also the arch_initcall should be omap_arch_initcall in linux next
>  Tony> for consistency if we ever have SoC specific sections for those.
>
> Sure, resent with the initcall change and netdev/devicetree-discuss added.
>
> --
> Bye, Peter Korsgaard
>

Thanks,
I added DT option mac-address-source because there is still possiblility to
have mac address set by the u-boot in the future. Beaglebone have special
eeprom on board, were you can have stored user MAC and u-boot can read
eeprom
data. Maybe some users will want this feature.  Also in cpsw dt binding
documentation, there is mention  /* Filled in by U-Boot */.  For that
purpose,
code I proposed can easily deal with any driver exteds.

Reading CPU mac address registers with (my approach) or without (your
approach) DT should be more discussed. Also your way seems to be fine.

Regards
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/6d8983db/attachment-0001.html>
