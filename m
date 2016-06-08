From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 8 Jun 2016 10:15:30 +0100
Subject: [Linux-kernel] [PATCH] pinctrl: nomadik: fix warnings from
 unexported functions
In-Reply-To: <d3712327-9d20-08ae-30b1-2b6d52e30420@codethink.co.uk>
References: <1465320302-5770-1-git-send-email-ben.dooks@codethink.co.uk>
 <d3712327-9d20-08ae-30b1-2b6d52e30420@codethink.co.uk>
Message-ID: <40be947d-89f6-2552-7bd2-91d16a378b2f@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 18:30, Ben Dooks wrote:
> On 07/06/16 18:25, Ben Dooks wrote:
>> There are five functions in the driver that are defined but
>> only used locally. Make these static to avoid the following
>> warnings:
>>
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1036:6: warning: symbol 'nmk_gpio_clocks_enable' was not declared. Should it be static?
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1050:6: warning: symbol 'nmk_gpio_clocks_disable' was not declared. Should it be static?
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1073:6: warning: symbol 'nmk_gpio_wakeups_suspend' was not declared. Should it be static?
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1094:6: warning: symbol 'nmk_gpio_wakeups_resume' was not declared. Should it be static?
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1120:6: warning: symbol 'nmk_gpio_read_pull' was not declared. Should it be static?
> 
> Apologies, wrong version of the patch without a typo fix in it.

Given these functions are not being used, should I just consider a
patch to remove these. If they are not being considered for future
development it might be a good idea?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genies
