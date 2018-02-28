From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 28 Feb 2018 17:41:14 +0200
Subject: [PATCH 2/2] serial: stm32: update interrupt initialization
In-Reply-To: <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-3-git-send-email-bich.hemon@st.com>
 <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
Message-ID: <CAHp75VeX_L_B2e648LiBrbHNBEg-C3NBw-PUTmQdhHhEb=2N-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 5:40 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 12:51 PM, Bich HEMON <bich.hemon@st.com> wrote:

>> -       port->irq       = platform_get_irq(pdev, 0);
>> -       stm32port->wakeirq = platform_get_irq(pdev, 1);

>> +       stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");
>
> But this one is redundant since Tony's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=da997b22c40473b7db60bde6ea188d35565d10c8

Oh, it'a bout getting a resource by name...

Sorry, discard my previous comment.


-- 
With Best Regards,
Andy Shevchenko
