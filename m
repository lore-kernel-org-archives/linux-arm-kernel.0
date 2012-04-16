From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 11:11:57 +0200
Subject: [PATCH] pinctrl: pinconf: Fix compilation error if PINCONF is not
 selected
In-Reply-To: <CACRpkdZFpknFE+WJ7-RnSti1MAJvwr=6QM98MkVrWDO+YHcy=g@mail.gmail.com>
References: <a342987ffebf0ab79a789011e17081e0169bdf24.1334566321.git.viresh.kumar@st.com>
 <CACRpkdZFpknFE+WJ7-RnSti1MAJvwr=6QM98MkVrWDO+YHcy=g@mail.gmail.com>
Message-ID: <CACRpkdbstx0Dk3e8TMP7faxcYZBo6ZJveH-Kh5T_W4hw0T0XmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:09 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Mon, Apr 16, 2012 at 10:52 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
>
>> When we compile pinctrl layer for platforms without CONFIG_PINCONF, we get
>> following compilation errors:
>>
>> drivers/built-in.o: In function `pinctrl_show':
>> linux-2.6/drivers/pinctrl/core.c:1116: undefined
>> reference to `pinconf_show_setting'
>> drivers/built-in.o: In function `pinctrl_maps_show':
>> linux-2.6/drivers/pinctrl/core.c:1071: undefined
>> reference to `pinconf_show_map'
>> drivers/built-in.o: In function `pinctrl_init_device_debugfs':
>> linux-2.6/drivers/pinctrl/core.c:1224: undefined
>> reference to `pinconf_init_device_debugfs'
>> make[1]: *** [.tmp_vmlinux1] Error 1
>>
>> This patch fixes this.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>
> Ooops! Patch applied. Will push this for the -rc:s.

Or no, wait, that was for the CONFIG_DEBUG_FS cleanup, so no need
to push to -rc:s since it's out-of-tree. Sorry for the confusion,
patch applied anyway.

Yours,
Linus Walleij
