From: panand@redhat.com (Pratyush Anand)
Date: Thu, 10 Dec 2015 17:20:18 +0530
Subject: [PATCH v12 12/16] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <56696514.3030209@linaro.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
 <20151203041525.GG14143@dhcppc13.redhat.com>
 <56696514.3030209@linaro.org>
Message-ID: <20151210115018.GA4695@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015:08:42:12 PM, AKASHI Takahiro wrote:
> >>+ * machine_crash_shutdown - shutdown non-boot cpus and save registers
> >
> >"non-panic" would be correct in stead of "non-boot".
> 
> OK, but for consistency with other places (say, arm/kernel/machine_kexec.c)
> I prefer "non-crashing cpus."

OK.

> 
> >>+	/* shutdown non-boot cpus */
> >
> >Ditto
> >
> >>+	smp_send_stop();
> >>+
> >>+	/* for boot cpu */
> >
> >"for panic cpu"
> 
> Ditto.
> "for crashing cpu"

OK.

~Pratyush
