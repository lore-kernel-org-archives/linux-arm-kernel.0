From: bernd@petrovitsch.priv.at (Bernd Petrovitsch)
Date: Thu, 07 Jun 2018 11:03:19 +0200
Subject: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
Message-ID: <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-07 at 14:08 +0530, Viresh Kumar wrote:
> On 07-06-18, 15:46, Du, Changbin wrote:
> > I think if the destination is not a null terminated string (If I understand your
> > description below), memcpy can be used to get rid of such warning. The warning
> > makes sense in general as explained in mannual. Thanks!
> 
> The destination should be a null terminated string eventually, but we first need
> to make sure src is a null terminated string.

Is there strnlen() or memchr() in the kernel?
Then check the source before copying it.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd at petrovitsch.priv.at
                     LUGA : http://www.luga.at
