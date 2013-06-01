From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 21:00:46 -0700
Subject: [PATCH 2/3] ARM: SAMSUNG: Consolidate uncompress subroutine
In-Reply-To: <1370000944-19786-3-git-send-email-tushar.behera@linaro.org>
References: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
 <1370000944-19786-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <20130601040046.GB3868@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 05:19:03PM +0530, Tushar Behera wrote:
> For mach-exynos, uart_base is a pointer and the value is calculated
> in the machine folder. For other machines, uart_base is defined as
> a macro in platform directory. For symmetry, the uart_base macro
> definition is removed and the uart_base calculation is moved to
> specific machine folders.
> 
> This would help us consolidating uncompress subroutine for s5p64x0.

Sorry, reading these in order and didn't go through all of them.

Same comment here, you can use config_enabled() and return early instead of
adding ifdefs.


-Olof
