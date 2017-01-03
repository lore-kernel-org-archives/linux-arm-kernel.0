From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 3 Jan 2017 11:20:44 +0100
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <CAFcVECK1vt7Hu4tgSZ2+kKpMxoT-wpikMDq65HaxRv-EMgobHA@mail.gmail.com>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
 <0717c63b-2e29-9ad1-7f01-39817980933f@atmel.com>
 <20170102161359.GD3609@localhost.localdomain>
 <CAFcVECK1vt7Hu4tgSZ2+kKpMxoT-wpikMDq65HaxRv-EMgobHA@mail.gmail.com>
Message-ID: <20170103102044.GB24780@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:36:11AM +0530, Harini Katakam wrote:
> I understand that it is not accurate - it is an initial version.

No, it is not inaccurate at all, it is WRONG.

This means that time stamps will be randomly associated with PTP
network packets.  To the application, the protocol will appear to
work, but the time stamp information (and thus the synchronization)
will be wrong.

To me, this is unacceptable, and I will push back on this driver
getting merged.

[ In contrast, the descriptor based approach would be ok, afaict. ]

Thanks,
Richard
