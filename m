From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 03 Jul 2014 18:57:00 +0100
Subject: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
In-Reply-To: <20140629114901.GO32514@n2100.arm.linux.org.uk>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
 <1402672899-6995-3-git-send-email-denis@eukrea.com>
 <53A55BD8.7030905@kernel.org>
 <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
 <53AFF1C4.1010402@kernel.org> <20140629114901.GO32514@n2100.arm.linux.org.uk>
Message-ID: <53B5996C.5000204@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/14 12:49, Russell King - ARM Linux wrote:
> On Sun, Jun 29, 2014 at 12:00:20PM +0100, Jonathan Cameron wrote:
>> On 21/06/14 20:55, Fabio Estevam wrote:
>>> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>> +
>>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>
>>>> Could this not in theory fail?
>>>
>>> Yes, but devm_ioremap_resource will take care of it, so we don't need
>>> to check for error here.
>> Nothing like counter intuitive behaviour.  Ah well.
>>
>> Thanks for explaining this!
>
> Maybe it would be better to have:
>
> 	mem = platform_ioremap_resource(pdev, IORESOURCE_MEM, 0);
>
> which wraps up both the platform_get_resource() call with
> devm_ioremap_resource() so driver writers don't have to be concerned
> about this aspect?
>
Good idea.

Something like that would certainly make more sense to me.
