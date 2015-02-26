From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Feb 2015 14:46:46 +0100
Subject: [PATCH v3 3/3] of: support passing console options with
 stdout-path
In-Reply-To: <54EF09AA.2080706@hurleysoftware.com>
References: <1417110967-16284-1-git-send-email-leif.lindholm@linaro.org>
 <1417110967-16284-4-git-send-email-leif.lindholm@linaro.org>
 <54EF09AA.2080706@hurleysoftware.com>
Message-ID: <20150226134646.GB8806@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 06:55:22AM -0500, Peter Hurley wrote:
> On 11/27/2014 12:56 PM, Leif Lindholm wrote:
> > Support specifying console options (like with console=ttyXN,<options>)
> > by appending them to the stdout-path property after a separating ':'.
> > 
> > Example:
> >         stdout-path = "uart0:115200";
> 
> This format breaks DT earlycon because libfdt doesn't recognize ':' as a
> path terminator.
> 
> It's simple enough to fix this directly in early_init_dt_scan_chosen_serial()
> but perhaps it would better to teach fdt_path_offset() to recognize ':'?

Hi Peter

ePAPR says for stdout-path in Chosen:

A string that specifies the full path to the node representing the
device to be used for boot console output. If the character ":" is
present in the value it terminates the path. The value may be an
alias.

So it is probably wise to implement this properly.

   Andrew
