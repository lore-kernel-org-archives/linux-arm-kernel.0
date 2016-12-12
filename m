From: v.narang@samsung.com (=?UTF-8?B?VmFuZWV0IE5hcmFuZw==?=)
Date: Mon, 12 Dec 2016 11:22:30 +0000
Subject: =?UTF-8?B?UkU6IFJlOiBbUEFUQ0ggMS8xXSBhcm0vbW9kdWxlOiBtYXhp?=
 =?UTF-8?B?bXVtIHV0aWxpemF0aW9uIG9mIG1vZHVsZSBhcmVhLg==?=
References: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
 <CGME20161212102403epcas4p2e039072e2acdc3d20c1b8ac86e823375@epcas4p2.samsung.com>
Message-ID: <20161212112230epcms5p6af05aef34f72eab15061a166d18cff00@epcms5p6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>A PC24 relocation has a range of +/-32MB.  This means that where-ever
>the module is placed, it must be capable of reaching any function
>within the kernel text, which may itself be quite large (eg, 8MB, or
>possibly larger).  The module area exists to allow modules to be
>located in an area where PC24 relocations are able to reach all of the
>kernel text on sensibly configured kernels, thereby allowing for
>optimal performance.
>
>If you wish to load large modules, then enable ARM_MODULE_PLTS, which
>will use the less efficient PLT method (which is basically an indirect
>function call) for relocations that PC24 can't handle, and will allow
>the module to be loaded into the vmalloc area.
>
>Growing the module area so that smaller modules also get penalised by
>the PLT indirection is not sane.

This is exactly what i am saying. These changes are useful to accomdate
22MB modules without enabling ARM_MODULE_PLTS. 
Without these changes ARM_MODULE_PLTS needs to be enabled to insert more than 14MB
modules but with these changes 22MB modules (considering 8MB uImage) can be inserted 
without enabling ARM_MODULE_PLTS.

So till 22MB modules are not penalised but without these changes once size of modules
gets over 14MB PLT becomes must.?

Regards,
Vaneet Narang
