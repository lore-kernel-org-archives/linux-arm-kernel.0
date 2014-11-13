From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Nov 2014 20:04:35 +0100
Subject: [linux-sunxi] Re: [PATCH 3/4] simplefb: Change simplefb_init
 from module_init to fs_initcall
In-Reply-To: <jwvy4rf2i7h.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>	<1415830124-28787-3-git-send-email-hdegoede@redhat.com>	<20141113085238.GE20972@lukather>
 <546478B5.2040002@redhat.com>	<CACxGe6u8B854PEWw8XzwhyX8joMWwOsHOOXtmBmC1TgCGjGtdg@mail.gmail.com>
 <jwvy4rf2i7h.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Message-ID: <546500C3.7040908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/13/2014 05:13 PM, Stefan Monnier wrote:
>> Like a lot of things, if it is made a modules, and it breaks for the
>> user, the user gets to keep the pieces.  There are potentially some
> 
> But the option's description should probably include some blurb about
> the fact that it only works as a module with some combinations of
> SoC+kernel.

So I was about to add an update of the Kconfig text along this line
while I was respinning the patch anyways, and guess what simplefb
currently cannot be build as a module, so this is a non-issue.

I'll update my "simplefb: Add support for enumerating simplefb dt nodes in /chosen"
patch to not have a module_exit in the next version, since that is
not really useful if it cannot be build as a module anyways.

Regards,

Hans
