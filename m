From: olofj@chromium.org (Olof Johansson)
Date: Mon, 18 Apr 2011 11:31:09 -0700
Subject: [PATCH] Fix infinite loop in ARM user perf_event backtrace code
In-Reply-To: <1302924445-18557-1-git-send-email-sonnyrao@chromium.org>
References: <1302924445-18557-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <BANLkTikwJzOXJGM4pcKmxVdP_2yb9uyeag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 8:27 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
>
> The ARM user backtrace code can get into an infinite loop if it
> runs into an invalid stack frame which points back to itself.
> This situation has been observed in practice. ?Fix it by capping
> the number of entries in the backtrace. ?This is also what other
> architectures do in their backtrace code.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
