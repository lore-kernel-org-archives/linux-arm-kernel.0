From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 4 Mar 2015 23:46:03 +0900
Subject: [PATCH v2 6/6] target-arm: cpu.h document why env->spsr exists
In-Reply-To: <1425479753-18349-7-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
 <1425479753-18349-7-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA9x_6jGfNTpMLYYbmEp19U7sOVjcgzCggwkwZiyCM5yug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 23:35, Alex Benn?e <alex.bennee@linaro.org> wrote:
> I was getting very confused about the duplication of state. Perhaps we
> should just get rid of env->spsr and use helpers that understand the
> banking?

Doesn't seem worth changing the current working code to something
else that's strictly less efficient... spsr is by no means the
only banked-by-mode register, and it works just like all the others.

-- PMM
