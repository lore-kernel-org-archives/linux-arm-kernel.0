From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jun 2014 12:49:01 +0100
Subject: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
In-Reply-To: <53AFF1C4.1010402@kernel.org>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
 <1402672899-6995-3-git-send-email-denis@eukrea.com>
 <53A55BD8.7030905@kernel.org>
 <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
 <53AFF1C4.1010402@kernel.org>
Message-ID: <20140629114901.GO32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 12:00:20PM +0100, Jonathan Cameron wrote:
> On 21/06/14 20:55, Fabio Estevam wrote:
>> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> +
>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>
>>> Could this not in theory fail?
>>
>> Yes, but devm_ioremap_resource will take care of it, so we don't need
>> to check for error here.
> Nothing like counter intuitive behaviour.  Ah well.
>
> Thanks for explaining this!

Maybe it would be better to have:

	mem = platform_ioremap_resource(pdev, IORESOURCE_MEM, 0);

which wraps up both the platform_get_resource() call with
devm_ioremap_resource() so driver writers don't have to be concerned
about this aspect?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
