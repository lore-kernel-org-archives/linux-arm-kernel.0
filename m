From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 4 Sep 2014 09:33:43 +0100
Subject: [SMP BUG?] the return value of is_smp() is bug?
In-Reply-To: <5407BCAE.7030606@huawei.com>
References: <1409550563-92081-1-git-send-email-long.wanglong@huawei.com>
 <540443DA.7030502@huawei.com> <25226905.0IHWyHSRxb@wuerfel>
 <5407BCAE.7030606@huawei.com>
Message-ID: <CAFEAcA82zX-yodXYB+4vVrjq7tVe=wV4v3iCQ7O1a1HLFX_B1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2014 02:13, long.wanglong <long.wanglong@huawei.com> wrote:
> When i revert the commit bc41b8724f24, the secondary core can boot.
> The problem is that qemu doesn't provide emulation of the SCU base
> address register. When reading the SCU base, qemu just return 0.

You need to upgrade your QEMU -- we improved the emulation
of all our Cortex-A9 boards to make sure they set valid values
for the base address register, in order to fix exactly this regression.
QEMU 2.0 or later should work.

(As an aside, I think the Aegis quirk test is pretty ugly:
"base address happens to be set to zero" is not exactly
a very reliable way to identify a particular SoC. However
in this case QEMU was emulating real h/w insufficiently
accurately, so we fixed it.)

thanks
-- PMM
