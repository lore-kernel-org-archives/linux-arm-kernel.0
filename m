From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Jan 2017 11:54:48 +0000
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
In-Reply-To: <9f508097-f605-ebd8-20af-c3e798c6fdcc@poczta.onet.pl>
References: <1483628549-29486-1-git-send-email-narmstrong@baylibre.com>
 <9f508097-f605-ebd8-20af-c3e798c6fdcc@poczta.onet.pl>
Message-ID: <83fd9b61-dbff-68e0-82e5-8e01058d04a9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Micha?,

On 05/01/17 19:04, Micha? Zegan wrote:
> Hello.
> 
> The patch causes cpufreq module (scpi-cpufreq) not to detect cpufreq, so
> it actually works, but...
> Loading the module causes few errors because of not found frequencies or
> something, then it is all okay. However after loading scpi-cpufreq you
> cannot actually power the cpu off and on. You will power it off
> successfully, but when trying to power it on, the cpufreq driver will
> error out, 

Yes I had noticed this in past, this needs to be fixed. I had a patch
and seems like it slipped through the cracks. I will fins and post it.

> and then after it happens, the cpu that was trying to go
> online will be offline again, and that is a little... unfortunate. The

IIUC, you mean the cpufreq drive spits error on every hotplug event ?
If so yes, otherwise I think I didn't understand you concern above.

> question is, and I cannot really test that: will the module actually
> autoload after this change?
>

It should work, I had tested this in past.

-- 
Regards,
Sudeep
