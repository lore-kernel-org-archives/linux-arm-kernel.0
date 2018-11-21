From: Al.Grant@arm.com (Al Grant)
Date: Wed, 21 Nov 2018 14:25:47 +0000
Subject: [RFC PATCH 1/3] drivers: amba: Updates to component
 identification for driver matching.
In-Reply-To: <CAJ9a7VjD1C3t=OtCpQNGvmSvDh-vPcR_2mObccJJ1Qv8_9BxFw@mail.gmail.com>
References: <20181115012842.2353-1-mike.leach@linaro.org>
 <20181115012842.2353-2-mike.leach@linaro.org> <20181120205737.GA17267@xps15>
 <CAJ9a7VjD1C3t=OtCpQNGvmSvDh-vPcR_2mObccJJ1Qv8_9BxFw@mail.gmail.com>
Message-ID: <AM6PR08MB36868BDA513BA392E01EDE9D86DA0@AM6PR08MB3686.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @devarch is defined as a 32 bit value. This is masked to widen / narrow
> matching. By default the mask will be the ARCHID field - bits 15:0, selected in the
> driver in the same way as the drivers currently have a mask for peripheral ID.
> This ignores the architect and version fields as most CS component drivers
> should handle differences.

The architect field defines what the ARCHID field means (the ARCHID
values are specific to each architect), it's not the same as the implementer
field. You need to check both if you want to know what component driver
to use. The correct mask for that is 0xfff0ffff.

Selecting on ARCHID alone, would only be valid if you are requiring the
architect always to be ARM (0x23b) and have already checked that.

Al
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
