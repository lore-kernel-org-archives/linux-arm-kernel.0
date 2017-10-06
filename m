From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 6 Oct 2017 17:04:01 +0530
Subject: [PATCH v3 15/22] firmware: arm_scmi: abstract mailbox interface
In-Reply-To: <f316b938-c6d5-3aa9-4f03-6b5c6ad4bfa7@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-16-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0EUr_aEZdOrjHixzp44yXqsNxTMzBceSBTmk-x8x2MAg@mail.gmail.com>
 <f316b938-c6d5-3aa9-4f03-6b5c6ad4bfa7@arm.com>
Message-ID: <CABb+yY0SmQaPgBxan44a_Sx2mFuuiPcMz41J1yjqfO5irPTYig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 5:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> Also, I have added shim only for specific controllers that need them.
> E.g. ARM MHU as Jassi disagreed to add doorbell mechanism to that.
> mbox_if provides default implementation that just calls direct mailbox
> APIs.
>
Yeah you could hack away the MHU driver to make your life easy at the
cost of duplicated code and extra DT bindings, but for a moment think
what if your development platform wasn't MHU but, say, Rockchip
mailbox controller?
