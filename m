From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 Aug 2012 13:21:30 -0600
Subject: [PATCH 5/8] video: vt8500: Add devicetree support for vt8500-fb
 and wm8505-fb
In-Reply-To: <76F764B079F92A4E843589C893D0A022D1DCA8D0@SERVER.prisktech.co.nz>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-6-git-send-email-linux@prisktech.co.nz>,
 <5022B444.2020501@wwwdotorg.org>
 <76F764B079F92A4E843589C893D0A022D1DCA8D0@SERVER.prisktech.co.nz>
Message-ID: <502BF6BA.9060407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 01:37 PM, Tony Prisk wrote:
>> On 08/07/2012 07:39 PM, Tony Prisk wrote:
>>> Update vt8500-fb, wm8505-fb and wmt-ge-rops to support device
>>> tree bindings.

>>> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> 
>>> +     np = of_find_node_by_name(NULL, "display");
>>> +     if (!np) {
>>> +             pr_err("%s: No display description in Device Tree\n", __func__);
>>> +             ret = -EINVAL;
>>> +             goto failed_free_res;
>>> +     }
> 
>> I believe that using hard-coded node names is frowned upon. Better would
>> be to put a phandle into the display controller's node that points at
>> the node representing the display, e.g.:
> 
> Will do.

I don't think this change made it into v2?
