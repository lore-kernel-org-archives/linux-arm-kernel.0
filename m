From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 01 Jun 2015 09:13:03 +0900
Subject: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <4edfb7fe9edf4800e73c86a258fe4fd1@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-28 22:03, Vaibhav Hiremath wrote:
> From: "Jett.Zhou" <jtzhou@marvell.com>
>
> TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
> of standard & fast mode in pxa910/988; so this patch adds these two 
> new
> entries to "struct pxa_reg_layout" and "struct pxa_i2c" and also adds 
> two
> new DT properties to take configuration value for the same.

Mapping registers 1:1 to DT is nearly always wrong. We have some 
generic bindings for SCL/SDA tweaking. Check 
Documentation/devicetree/bindings/i2c/i2c-designware.txt for them and if 
they match your needs. (Yes, they should be in a more generic place).
