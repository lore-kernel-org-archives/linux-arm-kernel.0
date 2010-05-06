From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Jimenez)
Date: Thu, 6 May 2010 10:24:23 -0300
Subject: Suspicious compilation warning
In-Reply-To: <p2g9c9fda241005051824k54e70136v8324d135b44c71b5@mail.gmail.com>
References: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>
	<20100420155122.6f2c26eb.akpm@linux-foundation.org>
	<20100420230719.GB1432@n2100.arm.linux.org.uk>
	<4BE14335.10702@ru.mvista.com>
	<p2g9c9fda241005051824k54e70136v8324d135b44c71b5@mail.gmail.com>
Message-ID: <n2ycecb6d8f1005060624y8ada0c03yc4fab915b3d13a0a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyungmin,

On Wed, May 5, 2010 at 22:24, Kyungmin Park <kmpark@infradead.org> wrote:
>
> Hi,
>
> It tested with my board and working.
> Just curious. If NR_SECTION_ROOTS is zero and uninitialized then
> what's problem? Since we boot and working without patch.

The original compiler error message was:

mm/sparse.c: In function '__section_nr':
mm/sparse.c:135: warning: 'root' is used uninitialized in this function

Leaving a variable to be used uninitialized is the issue here.

> Thank you,
> Kyungmin Park

Regards,
Marcelo.
