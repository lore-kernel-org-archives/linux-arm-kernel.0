From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Oct 2014 11:31:58 +0100
Subject: BPF crash with 3.18-rc1 on arm64 Juno hardware
In-Reply-To: <CABg9mcu0-AFNNOn+C4kbS7_rWqc-6WXZTyKUJYz6rA7-8OBqZA@mail.gmail.com>
References: <54493433.4090703@arm.com>
 <CABg9mcu0-AFNNOn+C4kbS7_rWqc-6WXZTyKUJYz6rA7-8OBqZA@mail.gmail.com>
Message-ID: <20141024103158.GB1955@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 06:23:49PM +0100, Z Lim wrote:
> On Thu, Oct 23, 2014 at 10:00 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > I see a crash with 3.18-rc1 on a Juno board related to bpf_jit (see dump
> > below). Userland tries to carry on afterwards, but eventually hangs in
> > RCU stalls.
> > The kernel has just CONFIG_BPF_JIT enabled, I guess Ubuntu enables this
> > automatically if detected.
> 
> When net-next and arm64-next merged in mainline, a silent failure is
> introduced due to new enhancements in net/bpf.
> This was actually uncovered before 3.18 merge window, and Daniel's
> patch to fix this was discussed here [1].
> I see that Catalin has queued up this patch in fixes/core [2].

Indeed. Pull request to Linus will go out later today.

-- 
Catalin
