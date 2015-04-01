From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 1 Apr 2015 15:45:20 +0800
Subject: [PATCH 1/2] pinctrl: at91: Add set_multiple GPIO chip feature
In-Reply-To: <CACRpkdapp8vGFHJA+WrZzRk503zoAzrz3HaVGYXH+CHRDaLaDg@mail.gmail.com>
References: <1426878721-2618-1-git-send-email-alexanders83@web.de>
 <CACRpkdapp8vGFHJA+WrZzRk503zoAzrz3HaVGYXH+CHRDaLaDg@mail.gmail.com>
Message-ID: <15EE7657-76F1-4AD4-B90B-C6A166301154@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

J
> On Mar 27, 2015, at 5:07 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> On Fri, Mar 20, 2015 at 8:12 PM, Alexander Stein <alexanders83@web.de> wrote:
> 
>> This adds the callback for set_multiple.
>> As this controller has a separate set and clear register, we can't write
>> directly to PIO_ODSR as this would required a cached variable and would
>> race with at91_gpio_set.
>> So build masks for the PIO_SODR and PIO_CODR registers and write them
>> together.
>> 
>> Signed-off-by: Alexander Stein <alexanders83@web.de>
>> ---
>> This was tested by using an own test driver which uses
>> gpiod_set_array_cansleep to set multiple GPIOs at once.
> 
> I remember J-C brought this up ages ago, so I hope he will be delighted
> to see we can now, FINALLY, do this!
> 
> J-C can I have your review on this?

I will check it tonight

Best Regards,
J.
