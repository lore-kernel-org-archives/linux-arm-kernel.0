From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 8 Aug 2012 19:37:24 +0000
Subject: [PATCH 5/8] video: vt8500: Add devicetree support for vt8500-fb
 and wm8505-fb
In-Reply-To: <5022B444.2020501@wwwdotorg.org>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-6-git-send-email-linux@prisktech.co.nz>,
 <5022B444.2020501@wwwdotorg.org>
Message-ID: <76F764B079F92A4E843589C893D0A022D1DCA8D0@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On 08/07/2012 07:39 PM, Tony Prisk wrote:
>> Update vt8500-fb, wm8505-fb and wmt-ge-rops to support device
>> tree bindings.

>> Small change in wm8505-fb.c to support WM8650 framebuffer color
>> format.

>That might warrant a separate patch?

The patch consisted of changing one value in one line and is commented in
the source. I didn't think it justified a separate patch as it has been thoroughly
tested and is unlikely to cause any problems.

>> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c

>> +     np = of_find_node_by_name(NULL, "display");
>> +     if (!np) {
>> +             pr_err("%s: No display description in Device Tree\n", __func__);
>> +             ret = -EINVAL;
>> +             goto failed_free_res;
>> +     }

>I believe that using hard-coded node names is frowned upon. Better would
>be to put a phandle into the display controller's node that points at
>the node representing the display, e.g.:

Will do.

Regards
Tony Prisk
