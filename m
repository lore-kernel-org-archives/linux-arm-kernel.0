From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Aug 2017 17:58:57 +0200
Subject: [PATCH] arm64: defconfig: Enable CONFIG_WQ_POWER_EFFICIENT_DEFAULT
In-Reply-To: <9fdfdc9f1593f0fb7780641ca0a9fba54baa1441.1501755972.git.viresh.kumar@linaro.org>
References: <9fdfdc9f1593f0fb7780641ca0a9fba54baa1441.1501755972.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a1Wjcy0Jv2ycosaYheHkz2wU4ji3U9ZthbrYyBkdBEPmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 3, 2017 at 12:28 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> commit cee22a15052f ("workqueues: Introduce new flag WQ_POWER_EFFICIENT
> for power oriented workqueues") introduced the concept of power
> efficient workqueues (4 years back), but it was never enabled in
> upstream kernel configs.
>
> Power efficient workqueues are simply marked as "unbound," so that jobs
> queued to them can run on any CPU in the system. It leaves the target
> CPU selection to the scheduler, which is the best place for such
> decision making. This improves power efficiency for workqueues which are
> otherwise pinned to a CPU.
>
> Enable it for ARM64 platforms as ARM platforms were the main target for
> the introduction of power efficient workqueues.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to next/defconfig, thanks!

     Arnd
