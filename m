From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 24 Oct 2016 10:30:12 +0300
Subject: [PATCH V7 4/4] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <36163853-ac4a-e146-0c1b-eaf42e8b234d@codeaurora.org>
References: <1477067879-23750-1-git-send-email-okaya@codeaurora.org>
 <1477067879-23750-5-git-send-email-okaya@codeaurora.org>
 <CAHp75Vd+u5va3kyqcapeF9JATUfv5gBnoEM_W+frDmMXs5f2Uw@mail.gmail.com>
 <36163853-ac4a-e146-0c1b-eaf42e8b234d@codeaurora.org>
Message-ID: <CAHp75VettN=-S+iqKQbqixRe2BM=AiS26VGM+8yLophbkc+Z8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 5:55 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 10/21/2016 12:11 PM, Andy Shevchenko wrote:
>>> +static void hidma_free_msis(struct hidma_dev *dmadev)
>>> > +{
>>> > +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> Perhaps one #ifdef and two definitions of functions?
>
> I don't think it will make a difference. I'll have to move
> #ifdef around the caller of hidma_free_msis instead which
> I think is uglier.
>
> The hidma_write_msi_msg function gets called only when
> CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined. If I don't put
> this around the function definition, I get unused function
> warning from the compiler. This is the reason why preprocessor
> definition is outside of the function definition.

I am talking about something like below:

#ifdef UGLY_DEFINE
myfunc_a()
{
}

myfunc_b()
{
}
#else
static inline myfunc_a() {}
static inline myfunc_b() {}
#endif


There is another way as well, namely use of IS_ENABLED(), IS_BUILTIN()
macros (I don't remember how exactly second one is spelt).

-- 
With Best Regards,
Andy Shevchenko
