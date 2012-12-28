From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 28 Dec 2012 22:49:23 +0300
Subject: [PATCH] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <1356706349-3189-1-git-send-email-mikedunn@newsguy.com>
References: <1356706349-3189-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <50DDF7C3.40303@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/28/2012 05:52 PM, Mike Dunn wrote:

> This patch fixes some code that implements a work-around to a hardware bug in
> the ac97 controller on the pxa27x.  A bug in the controller's warm reset
> functionality requires that the mfp used by the controller as the AC97_RESET_n
> line be temporarily reconfigured as a generic output gpio (AF0) and manually
> held high for the duration of the warm reset cycle.  This is what was done in
> the original code, but it was broken long ago by commit
> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6, which changed the mfp to a GPIO input

   Please also specify the summary of that commit in parens.

> instead of a high output.

> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>

WBR, Sergei
