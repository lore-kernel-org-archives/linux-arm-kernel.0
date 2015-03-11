From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Mar 2015 14:41:58 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: sun6i: dt: Add new Mele I7 device
In-Reply-To: <54FF714F.4010303@redhat.com>
References: <1425131285-8640-1-git-send-email-codekipper@gmail.com>
 <20150303071635.GC4713@lukather> <54F568F8.1040104@redhat.com>
 <20150303082209.GE4713@lukather> <54F5B51F.6030609@redhat.com>
 <20150303135847.GH4911@lukather> <54FED277.4040000@redhat.com>
 <20150310184449.GZ5085@lukather> <54FF714F.4010303@redhat.com>
Message-ID: <20150311134158.GM5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 11:33:51PM +0100, Hans de Goede wrote:
> >>>and we have no way to replace U-Boot in NAND
> >>>so far (afaik). But replacing them by stdout-path is a very good
> >>>solution too.
> >>
> >>You mean putting stdout-path in the dts, I'm not sure if I like that,
> >>to me both bootargs and stdout-path are something which should be
> >>left to the bootloader to set. But I understand that when not
> >>using upstream u-boot that may be an issue.
> >
> >I know that some other platforms ask for stdout-path when they review
> >it, because iirc, barebox uses it to know on which console to output
> >its log and export its shell, which is also a valid interpretation of
> >that property, and, contrary to bootargs, doesn't really imply that
> >the bootloader should update it.
> 
> Hmm, that is interesting we should probably start doing the same in
> all the sunxi dts files, as eventually I would like to move all u-boot
> board config to devicetree, so that we only need to maintain dts files
> and not both dts files and u-boot board configs.

I had the plan to remove all earlyprintk in the bootargs of the DTS, I
can do it to convert all DTS to use stdout-path as well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/5a9f21a7/attachment.sig>
