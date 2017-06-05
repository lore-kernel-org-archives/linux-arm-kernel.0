From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 5 Jun 2017 11:20:53 +0200
Subject: Small issue with 3fde2999fac5 "arm64: cpufeature: Don't dump
 useless backtrace on CPU_OUT_OF_SPEC"
In-Reply-To: <20170605084840.GB4650@leverpostej>
References: <7f8ade0a-c4ab-3e2e-d21e-8eab4df07cac@gmail.com>
 <20170605084840.GB4650@leverpostej>
Message-ID: <8ff72bb8-d8be-e691-c939-5f7d73f5e3d9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.06.2017 um 10:48 schrieb Mark Rutland:
> Hi,
> 
> On Sun, Jun 04, 2017 at 02:53:36PM +0200, Heiner Kallweit wrote:
>> The warning is printed unconditionally. An "if (taint)" seems to be
>> missing.
> 
> I'm not sure I follow. We're using pr_warn_once(), which should only
> print the message once, regardless of how many times it is called.
> 
Before we had WARN_TAINT_ONCE(taint, ..), so the warning is
triggered by taint != 0.
Now the warning is printed (just once but) even if taint == 0.

> Is that not working correctly for you?
> 
> If so, could you please report so on LAKML? That way others can get
> involved with investigating and fixing the issue.
> 
> Thanks,
> Mark.
> 

Rgds, Heiner
