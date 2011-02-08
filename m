From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 8 Feb 2011 16:31:02 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <20110208162515.GB6188@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<201102081615.15713.arnd@arndb.de>
	<20110208162515.GB6188@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinD=jVXWdzH_LwbFy=En3LYrZ-Byu0JiFDAxNxd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 8, 2011 at 4:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 04:15:15PM +0100, Arnd Bergmann wrote:
>> But that doesn't work if you build a combined v5/v6/v7 kernel, because
>> v5 supports neither form, right? I think to do that, it needs the
>> same kind of abstraction that we have for a number of other things
>> like cache management in arch/arm/mm/.
>
> The options are kernels which support v3-v5 or v6-v7. ?There's too big
> a change between v5 and v6 to combine those into one kernel.
>

Indeed... wfi() is a good example of where being generic gets hard...
some v5 processors (typically those with caches) implement the same
MCR supported by v6, but it's not universal.  Typically v4 processors
have no WFI capability.

---Dave
