From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Nov 2015 18:45:10 -0200
Subject: mx28: bad unlock balance detected
In-Reply-To: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
References: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
Message-ID: <CAOMZO5D_ZANC30EJYpmpSenZwyx7-M=HC2nFoya_YBD1CS84+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 2:18 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Running linux-next 20151126 on a mx28evk leads to the following bug:
>
> sgtl5000 0-000a: sgtl5000 revision 0x11
> sgtl5000 0-000a: Using internal LDO instead of VDDD
>
> =====================================
> [ BUG: bad unlock balance detected! ]
> 4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted
> -------------------------------------
> kworker/u2:0/6 is trying to release lock (&rdev->mutex) at:
> [<c02e7858>] regulator_get_voltage+0x30/0x44
> but there are no more locks to release!

This warning started appearing in linux-next 20151123 according to these logs:
http://arm-soc.lixom.net/bootlogs/next/next-20151123/wandboard-arm-imx_v6_v7_defconfig.html

Haven't run git bisect yet.
