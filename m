From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Apr 2012 23:06:10 +0200
Subject: [PATCH] pinctrl: Replace list_*() with get_*_count()
In-Reply-To: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
References: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
Message-ID: <CACRpkdbr2Ais8m01PBkTzX56KfdA6q6161gET3v_kg6JmY=PHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 7:55 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Most of the SoC drivers implement list_groups() and list_functions() routines
> for pinctrl and pinmux. These routines continue returning zero until the
> selector argument is greater than total count of available groups or functions.
>
> This patch replaces these list_*() routines with get_*_count() routines, which
> returns the number of available selection for SoC driver. pinctrl layer will use
> this value to check the range it can choose.
>
> This patch fixes all user drivers for this change. There are other routines in
> user drivers, which have checks to check validity of selector passed to them. It
> is also no more required and hence removed.
>
> Documentation updated as well.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Thanks, applied and fixed up...
Yours,
Linus Walleij
