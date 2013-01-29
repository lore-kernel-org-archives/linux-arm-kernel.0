From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Tue, 29 Jan 2013 12:02:54 +0000
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
 <1359445134-13323-2-git-send-email-manishv.b@ti.com>
 <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
Message-ID: <A4887BF146CD57468F700B415D2F4701581AE9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Jan 29, 2013 at 16:29:54, Linus Walleij wrote:
> On Tue, Jan 29, 2013 at 8:38 AM, Vishwanathrao Badarkhe, Manish <manishv.b@ti.com> wrote:
> 
> > Currently, I2C driver gets probed before pinctrl driver.
> > To achieve I2C pin muxing via pinctrl driver before I2C probe get 
> > called, register pinctrl driver in arch_initcall.
> > Also, add module_exit to unregister pinctrl driver.
> >
> > Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
> 
> So your I2C driver is not returning -EPROBE_DEFER if it cannot find its pins?
Yes. In Davinci I2C driver, it's not implemented to return -EPROBE_DEFER if it 
can't find its pins.

Please see below discussion for more details: 
https://patchwork2.kernel.org/patch/2031321/
 
> 
> Hm, well I can live with this, if Tony ACKs it.
> 
> Yours,
> Linus Walleij
> 


Regards, 
Manish
