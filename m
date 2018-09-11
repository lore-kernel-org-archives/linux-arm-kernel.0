From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Sep 2018 08:03:06 -0700
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
Message-ID: <CAOesGMhViv_D6GKYf3x02LGqthwEsfkUFWBdG7pCQqD2MGsEew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jolly,

On Mon, Sep 10, 2018 at 12:17 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> Hi All,
>
> Adding more clarification on top of what Michal said:
> Here ioctl is not a system ioctl and just a eemi API like other interface APIs. It cannot be called from userspace. Only Linux drivers can use this API for defined ioctl operations. This API is meant for any platform specific operations which needs to be managed by firmware. Firmware will always validate the request for action being performed.
> Debugfs interface is just for debugging during development. We can remove debugfs support for ioctl API if you suggest.

Are there any pending patchsets that make use of the ioctl interface
besides the debugfs piece? None of the ones in this pull request
(besides the debugfs) seems to call into it.

It might just be easier to leave it out until you have a use case for
it. The rest of the patchset looks fine to me, and I'd be happy to
take it. Once you have a need for it we can discuss specifics.


-Olof
