From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 10 Nov 2014 10:54:00 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAMAWPa_f1K1qUG_UTmM0w8Sz8wed7+CQkK9tc8t1W=CTJvdjyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 5:33 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> We rely on probe order of this driver to determine the line number for
> the uart port. This makes it impossible to know the line number
> when these devices are populated via DT. Use the DT alias
> mechanism to assign the line based on the aliases node.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

FYI... this patch hit linux-next and caused multiple boot failures on
qcom platforms[1] as of next-20141110.  I'm assuming this is because
the corresponding DTS changes have not hit linux-next yet.

Kevin

[1] http://status.armcloud.us/boot/?qcom
