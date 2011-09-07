From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 7 Sep 2011 18:23:10 +0530
Subject: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
In-Reply-To: <87sjo8ttwf.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83Zv+sX1G4saFsU=bOUYjedcM6eYEOCVMKqMZ-5pxkBc6x2A@mail.gmail.com>
	<87sjo8ttwf.fsf@ti.com>
Message-ID: <CAC83ZvKjCCFPOqP9pBF=4bmz+cPhUna2BaYR9jbJzWN_WPT+YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 6:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> [...]
>>>> + ? ? /*
>>>> + ? ? ?* If this is the first gpio_request for the bank,
>>>> + ? ? ?* enable the bank module.
>>>> + ? ? ?*/
>>>> + ? ? if (!bank->mod_usage)
>>>> + ? ? ? ? ? ? if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
>>>
>>> All of the IS_ERR_VALUE() usage is wrong here. ?You're checking if the
>>> result of IS_ERR_VALUE() is < 0 which will never happen.
>> No.
>> IS_ERR_VALUE is applied on the return value of pm_runtime_get_sync
>> which is < ?0.
>
> ...and is still not correct.
>
> The result of the '< 0' check will be zero or one, so IS_ERR_VALUE()
> will never be true.
Ok.

>
> Kevin
>
