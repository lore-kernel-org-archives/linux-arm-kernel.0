From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Mar 2015 14:14:28 +0000
Subject: [PATCH] arm64: Get rid of struct cpu_table
In-Reply-To: <CAKv+Gu-H=q7HsFx-BAUPOOxsA9O7VT=zz4B8rJ5P2_CmF4oLNw@mail.gmail.com>
References: <1426248133-20032-1-git-send-email-marc.zyngier@arm.com>
 <CAKv+Gu-H=q7HsFx-BAUPOOxsA9O7VT=zz4B8rJ5P2_CmF4oLNw@mail.gmail.com>
Message-ID: <20150313141427.GB17279@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 02:33:27PM +0100, Ard Biesheuvel wrote:
> On 13 March 2015 at 13:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > struct cpu_table is an artifact left from the (very) early days of
> > the arm64 port, and its only real use is to allow the most beautiful
> > "AArch64 Processor" string to be displayed at boot time.
> 
> Heh, I looked at that code and assumed it was there for a reason.
> Apparently not :-)

There's a very good reason _not_ to be there: it encourages people to
add implementation specific tweaks to the early kernel boot code. These
must be done in firmware or boot-loader.

-- 
Catalin
