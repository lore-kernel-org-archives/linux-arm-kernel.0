From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Aug 2012 09:34:48 -0600
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
Message-ID: <5034FC18.2090400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2012 08:38 AM, Linus Walleij wrote:
> (Hm maybe I should've read this patch first, well whatever.)
> 
> On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> 
>> This is also include the gpio controller as the IP share both.
>> Each soc will have to describe the SoC limitation and pin configuration via
>> DT.

>> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt

>> +Required properties for iomux controller:
>> +- compatible: "atmel,at91rm9200-pinctrl"
>> +- atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
>> +  configured in this periph mode. All the periph and bank need to be describe.
> 
> Can you please be more elaborate on this mux-mask, like what each bit
> means and why the bits are arranged like that and what it means on the
> AT91 platform.... I was first reading the .dts and was like ?woot? so
> I go to the bindings doc and I read this and I'm still like ?woot?..

Yes, I'm a little confused what this is, and wouldn't have a clue how to
fill it in.

>> +static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
>> +                       struct device_node *np,
>> +                       struct pinctrl_map **map, unsigned *num_maps)
> 
> DT parse code, looks nice but would request Stephen to have a look
> at it.

I think it looks reasonable; I don't see any obvious issues at a quick
glance.
