From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Dec 2014 10:59:08 +0000
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <CAL_JsqJuSa-zHTPynH3vAEOK1D2xYRYtVjZJ5zDR0UHAyGYXuA@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201406182122.29623@pali>
 <CAL_JsqK5j8PvYfq+tct4RMr63TWDYGfi_TA28k5m4KyG=UuNbg@mail.gmail.com>
 <201411242319.27481@pali>
 <CAL_JsqJuSa-zHTPynH3vAEOK1D2xYRYtVjZJ5zDR0UHAyGYXuA@mail.gmail.com>
Message-ID: <20141204105908.GM11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 06:33:08PM -0600, Rob Herring wrote:
> On Mon, Nov 24, 2014 at 4:19 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> > There is no "/serial-number" property in kernel:
> >
> > $ ls -l -a /sys/bus/soc/devices/soc0/
> > drwxr-xr-x    3 0        0                0 Jan  1 00:00 .
> > drwxr-xr-x   18 0        0                0 Jan  1 00:00 ..
> > -r--r--r--    1 0        0             4096 Jan  1 00:00 family
> > -r--r--r--    1 0        0             4096 Jan  1 00:00 machine
> > drwxr-xr-x    2 0        0                0 Jan  1 00:00 power
> > -r--r--r--    1 0        0             4096 Jan  1 00:00 revision
> > lrwxrwxrwx    1 0        0                0 Jan  1 00:00
> > subsystem -> ../../bus/soc
> > -r--r--r--    1 0        0             4096 Jan  1 00:00 type
> > -rw-r--r--    1 0        0             4096 Jan  1 00:00 uevent
> 
> Wrong place. If you put /serial-number in your DT, then it will be in
> /proc/device-tree/serial-number.
> 
> If you want to wire that up to /proc/cpuinfo, I would be fine with that.

That would be fine for me too.  Then it's just a matter of how to copy
the contents of the ATAG into the DT (I assume it's possible in a
similar way to the memory and command line information.)  That's
something I know nothing about though.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
