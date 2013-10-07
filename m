From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 07 Oct 2013 10:39:21 +0200
Subject: [PATCH] clk: provide public clk_is_enabled function
In-Reply-To: <CAPtuhTiaTX1VX0OnkJN6AeqtT+FW+uK7022iJ2wOCirQmMXH4Q@mail.gmail.com>
References: <1380881310-24345-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131005202430.GI10079@pengutronix.de> <20131005204208.GB28106@lunn.ch>
 <20131006090609.GK14747@book.gsilab.sittig.org>
 <20131006163011.GA30818@lunn.ch> <5251BD09.3050900@gmail.com>
 <20131006200223.32214.4440@quantum> <5251E334.2070008@gmail.com>
 <CAPtuhTiaTX1VX0OnkJN6AeqtT+FW+uK7022iJ2wOCirQmMXH4Q@mail.gmail.com>
Message-ID: <52527339.9090701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2013 11:04 PM, Mike Turquette wrote:
> On Sun, Oct 6, 2013 at 3:24 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>> Of course, we can do clk_enable, read, clk_disable as said before - and
>> given the amount of questions and misinterpretation, I think it is the
>> saner way.
>
> Sorry for any misinterpretation on my end. I agree reading the
> register(s) within a clk_enable/clk_disable-protected section is the
> most sane option.

Well, as you are not the only one misinterpreting the purpose, I
guess it is more about the clk_is_enabled() function itself. Uwe was
very right, that it will lead to patches using it in a wrong way.

Using the common enable/disable functions does no harm to our workaround
and we will use it.

Thanks for taking the time to raise those questions and surface those
critical interpretations early!

Sebastian
