From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Apr 2013 06:56:48 -0700
Subject: [PATCH v4] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
 <CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
Message-ID: <CAD=FV=UddWM=yc5N9=jwbMDpZ7Bpg7o3Z714CnBSg=iHhmPxWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, Apr 10, 2013 at 5:48 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The call to regulator_enable() is prior to the call to mmc_add_host().
> Hence, call to mmc_fre_host is not required in this case. So the above
> change should be right.

Are you sure that mmc_free_host() is the opposite of mmc_add_host()
and not mmc_alloc_host()?

I'll double-check myself in a few hours when I'm in front of a computer.

-Doug
