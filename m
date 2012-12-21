From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Dec 2012 09:53:56 -0200
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <20121221114953.GA2678@pengutronix.de>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
 <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
 <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
 <20121221022249.GA16251@nchen-desktop>
 <CAOMZO5B3EXOB4ijh0LOhvU4g67kdz8KSXw8dvS2dOD1anu_8Bw@mail.gmail.com>
 <20121221114953.GA2678@pengutronix.de>
Message-ID: <CAOMZO5CdNsFJgYW-DAeS7jEh4r+4RwyvasvJGgfzaeXM3X02bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 9:49 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:

>> Yes, setting CI13XXX_DISABLE_STREAMING inside ci_role_start does work.
>>
>> If you think the patch below is fine I can properly submit it.
>
> Why did you need to move this function?

Only to make the compiler happy. hw_write() is now used by
ci_role_start(), so I re-ordered so that  hw_write comes first in the
code and compiler does not complain.

Regards,

Fabio Estevam
