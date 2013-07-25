From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 15:21:35 +0200
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <20130725131556.GD9858@sirena.org.uk>
References: <1624911.6TtmtVmU1T@avalon>
 <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
 <1408178.cxAUTUGJc5@avalon> <20130725131556.GD9858@sirena.org.uk>
Message-ID: <CACRpkdY-mdLbMY16aMqR9Jwu8qs9q4KNyxOxnwhXiGrAAxpKjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 3:15 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 25, 2013 at 11:45:33AM +0200, Laurent Pinchart wrote:
>
>> The number of interrupts can be pretty high (up to 58 in the worst case so
>> far), so an alternative would be to specify the interrupt-parent only, and
>> call irq_create_of_mapping() directly. What solution would you prefer ?
>
> Are the interrupts in a contiguous block in the controller so you can
> just pass around the controller and a base number?

That works with platform data and in-kernel structures, but AFAICT
device tree has no such "bulk" concept but expects you to list
each and every line individually in cases like this.

Yours,
Linus Walleij
