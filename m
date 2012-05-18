From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 18 May 2012 09:13:42 +0530
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <20120518000800.B9F333E062C@localhost>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
 <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
 <CAOh2x=nizQYXWFu3deQPXr93Nqv77Pnj5DNhYZw_vYyY2go3vA@mail.gmail.com>
 <CACRpkdZGAQpt1bqhTFmxcC7OKb4uds6ru-aNs-aT+M+H4TKuJg@mail.gmail.com>
 <20120518000800.B9F333E062C@localhost>
Message-ID: <4FB5C56E.8070705@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2012 5:38 AM, Grant Likely wrote:
> however, there is a bigger issue now.  I'm changing the xlate
> mechanism to allow multiple gpio_chips to refer to the same device
> tree node which will break the assumption that this patch uses.  The
> reason for this is to make it easier to support banked gpio
> controllers where a separate gpio_chip is used for each bank, but it
> is still described by a single device tree node.  To properly resolve
> this will require a full gpio specifier reference instead of just the
> phandle.  Will that work for your use-case?

What about the other routine i suggested yesterday

of_get_gpio_chip_base_by_phandle()?

This would work with your updates too and will work for me as well.

-- 
viresh
