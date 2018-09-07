From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Sep 2018 10:14:31 -0700
Subject: [PATCH] firmware: arm_scmi: use strlcpy to ensure NULL-terminated
 strings
In-Reply-To: <1536339135-5431-1-git-send-email-sudeep.holla@arm.com>
References: <1536339135-5431-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAOesGMiRYFuMDbs9bogSRz-85d_+JYh39ktvYeY2fuUL4Pmr6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 7, 2018 at 9:52 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Replace all the memcpy() for copying name strings from the firmware with
> strlcpy() to make sure we are bounded by the source buffer size and we
> also always have NULL-terminated strings.
>
> This is needed to avoid out of bounds accesses if the firmware returns
> a non-terminated string.
>
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

In case I don't end up applying it:

Acked-by: Olof Johansson <olof@lixom.net>

> Let me know if this is rc/fix material or need to wait for v4.20 ?

I don't see a reason to merge this as a fix, it's more of a cleanup.


-Olof
