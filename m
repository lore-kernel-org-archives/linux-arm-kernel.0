From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 27 Jun 2015 14:36:44 +0900
Subject: [PATCH] mfd: 880m80x: Make use of BIT() macro
In-Reply-To: <1435324091-2196-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435324091-2196-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAJKOXPd3Wjs2+yFpruxMKQmjVD1+h0QPHD8TC-0YLrXhnxUkbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-26 22:08 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> Instead of hard coding the shift for bit definition, use
> BIT() macro.

I am not convinced that such change improves anything in existing
code. IMHO (1 << n) is quite readable and obvious. The obviousness of
it, is the same as obviousness of BIT(n). However I know that Lee
Jones likes the BIT() so it's up to him :) .

In the same time you are cleaning a little the indentation in defines
which is nice, but messes with main change. It is difficult to find
the exact differences, to review it. Can you split the patch into two
commits - one for BIT (if this is desired by Lee Jones) and one for
white space clean up?

Best regards,
Krzysztof
