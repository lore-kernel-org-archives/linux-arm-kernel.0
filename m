From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 22:00:11 +0200
Subject: [GIT PULL 3/5] firmware: tegra: Changes for v4.20-rc1
In-Reply-To: <20180927205942.30878-3-thierry.reding@gmail.com>
References: <20180927205942.30878-1-thierry.reding@gmail.com>
 <20180927205942.30878-3-thierry.reding@gmail.com>
Message-ID: <CAK8P3a0jFjOUQ33hop0cn0HqRra8iRGbKPq_i+RAyZ89BWzSRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 10:59 PM Thierry Reding
<thierry.reding@gmail.com> wrote:

> firmware: tegra: Changes for v4.20-rc1
>
> This contains a fix for suspend/resume support for the BPMP found on
> Tegra186 and Tegra194.
>
> ----------------------------------------------------------------
> Thierry Reding (1):
>       firmware: tegra: bpmp: Implement suspend/resume support
>
>  drivers/firmware/tegra/bpmp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

This causes a build warning in randconfig builds:

drivers/firmware/tegra/bpmp.c:847:12: error: 'tegra_bpmp_resume'
defined but not used [-Werror=unused-function]
 static int tegra_bpmp_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~

Please fix and resubmit. Thanks,

     ARnd
