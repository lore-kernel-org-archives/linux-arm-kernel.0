From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 10:06:21 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <51076FA2.9070002@ti.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <20130121232322.GK15361@atomide.com> <50FE307F.9000701@ti.com>
 <201301220931.24570.arnd@arndb.de> <50FE666B.10902@ti.com>
 <20130122145113.GK23505@n2100.arm.linux.org.uk> <50FEAABA.6050307@ti.com>
 <510615F8.7010203@ti.com> <5107114C.4070307@linaro.org>
 <51076FA2.9070002@ti.com>
Message-ID: <20130129100621.GO23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 12:13:46PM +0530, Santosh Shilimkar wrote:
> To avoid the server latency, we didn't do continuous sync. The time was  
> synced in the beginning and after 62.5 hours (#ntpd -qg) and the drift
> of about 174 ms was observed. As you said this could be because of
> server sync time along with probably some addition from system calls
> from #ntpd. As mentioned, the other run with HZ = 128 which started
> 15 hours 20 mins is already showing about 24 mS drift now. I will
> let it run for couple of more days just to have similar duration run.

Hmm.  I wonder if ntpd -qg will cause ntp to read the drift file and
adjust the kernel time keeping using that information...
