From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 6 Oct 2017 16:56:01 +0530
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
Message-ID: <CABb+yY1N6hmC6Kd2QteMw_oCf=-mYHf7p6RdhYPQK+QUO7VP4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 5:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This patch adds ARM MHU specific mailbox interface for SCMI.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> This clearly needs an explanation why we need another driver.
>
Yes the patch needs explanation which is that we need a shim layer to
map SCMI requests onto what the underlying controller expects. The
alternative was to clone the controller driver (MHU now and others
later when their platforms support SCMI) and pretend SCMI is the only
client they are ever going to serve.

BTW, I haven't reviewed this patchset yet so I am not sure about this
code but I do believe we need a transport layer (this shim driver)
between generic SCMI implementation and each controller driver.
