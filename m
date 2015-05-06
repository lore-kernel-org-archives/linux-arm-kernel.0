From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 May 2015 14:40:27 -0300
Subject: Arm Memory Map clarification
In-Reply-To: <CAGUYZuQXmJoD_FEtZwX_eBBv-DO019tb1soTXgc-0Qjk_QSSLw@mail.gmail.com>
References: <CAGUYZuQXmJoD_FEtZwX_eBBv-DO019tb1soTXgc-0Qjk_QSSLw@mail.gmail.com>
Message-ID: <CAOMZO5COEVapXp6uwuD5cQKq0XH9E458cCkvUezAw6WqBURjmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 1:39 AM, sanjeev sharma
<sanjeevsharmaengg@gmail.com> wrote:
> Hello All,
>
> I am working on 3.14 kernel for Nitrogen6x Board and during dealing
> with IPU, I have realized that as per Table 2-1 (System memory map) of
> the i.MX6 (Q) Reference Manual(Rev2,06/2014) IPU-1 base address is
> 0x0260_0000 but device Tree Node defined in imx6qdl.dtsi for IPU-1 i.e
> alias of IPU0 is at @02400000 and for IPU-2
> base address is defined at 0x02A0_0000 as per Table 2-1 (System memory
> map) of the i.MX6 (Q) Reference Manual but device Tree Node defined in
> imx6q.dtsi for IPU-2 i.e alias of IPU1 is at @02800000.

Yes, this is a bit confusing.

imx6qdl.dsti says the ipu1 starts at 02400000. If you look at ipu-common.c:

static struct ipu_devtype ipu_type_imx6q = {
    .name = "IPUv3H",
    .cm_ofs = 0x00200000,

This .cm_ofs is used as the offset, which leads to 0x02600000 as
described in the Reference Manual.

Regards,

Fabio Estevam
