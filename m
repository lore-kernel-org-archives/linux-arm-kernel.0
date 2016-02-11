From: monstr@monstr.eu (Michal Simek)
Date: Thu, 11 Feb 2016 19:58:19 +0100
Subject: [PATCH 3/3] ARM64: zynqmp: Use 64bit size cell format
In-Reply-To: <CAL_JsqK0=LaXqJyr_rGKCzGgt5kFy79-4ARocTGpKved3JU-Ug@mail.gmail.com>
References: <2f160e012080d5d6de11238ade239bb0bb224f64.1455193571.git.michal.simek@xilinx.com>
 <36fb9c4c9b2019b854e84dc0a9a01252a6de2337.1455193571.git.michal.simek@xilinx.com>
 <CAL_JsqK0=LaXqJyr_rGKCzGgt5kFy79-4ARocTGpKved3JU-Ug@mail.gmail.com>
Message-ID: <56BCD9CB.9030803@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 11.2.2016 17:13, Rob Herring wrote:
> On Thu, Feb 11, 2016 at 6:26 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Use 64bit size cell format instead of 32bit for memory
>> description. Change 64bit sizes also for all others IPs.
> 
> Why? As is, this change is completely pointless because nothing needs
> a >4GB size. Do you have peripherals with >4GB size?

The change I need to do is to support more than 4GB memory. Memory space
is divided to some parts. 2GB connected to hard part below 4GB. There
there is 1GB connected to PL part below. Then 32GB hard part above of
4GB and a lot of space for PL part (~230GB).

PCIe can also address more than 256GB.

That's why I stand before decision. Change size-cell for all IPs which
are currently listed. Or just change it for memory node which is listed
in mainline.
I am not quite sure how PCIe description will look like and if there is
any other IP which will required on current buses use sizes more that
4GB. That's why I have change all sizes to support more than 4GB.

But definitely current need is to support more than 4GB memory size and
I have no problem to use not empty ranges property and keep there
#size-cells = <1>;

Both solution works for me. Definitely thank you for your comments.

Thanks,
Michal


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/4e1ce5ef/attachment.sig>
