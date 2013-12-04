From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 3 Dec 2013 23:04:42 -0800
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
Message-ID: <20131204070442.GA31665@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:39:21PM -0500, Adrien Verg? wrote:
> Usage of ETM tracing facility is currently very limited: user can
> only start/stop tracing. This set of patches enables management of
> address combinations and PIDs that trigger tracing.
> 
> ETM management was done via sysfs entries (trace_info,
> trace_running...), this code adds trace_addrrange and trace_pid to
> let the user read/write custom values.

I have lots to say about this from a sysfs point of view, but first, why
is it in sysfs at all?  Shouldn't all of this be in debugfs?

greg k-h
