From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 26 Feb 2018 07:57:04 -0800
Subject: [PATCH v6 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAOFm3uE8q63h-zk3FGnZkDqvxjJj=d0mfuUtK+nyioKosmt=dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep,

On Fri, Feb 23, 2018 at 8:23 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The SCMI is intended to allow OSPM to manage various functions that are
> provided by the hardware platform it is running on, including power and
> performance functions. SCMI provides two levels of abstraction, protocols
> and transports. Protocols define individual groups of system control and
> management messages. A protocol specification describes the messages
> that it supports. Transports describe the method by which protocol
> messages are communicated between agents and the platform.
>
> This patch adds basic infrastructure to manage the message allocation,
> initialisation, packing/unpacking and shared memory management.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

<snip>


> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -0,0 +1,77 @@
> +/*
> + * System Control and Management Interface (SCMI) Message Protocol
> + * driver common header file containing some definitions, structures
> + * and function prototypes used in all the different SCMI protocols.
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program. If not, see <http://www.gnu.org/licenses/>.
> + */

Would you consider using the SPDX tags [1] instead of this legalese?
Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
