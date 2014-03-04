From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Mar 2014 23:16:26 +0100
Subject: [PATCH RFC 3/6] tty: Rename xilinx_uart -> cadence_uart
In-Reply-To: <20140304193913.71c6f307@alan.etchedpixels.co.uk>
References: <1393953449-28551-1-git-send-email-soren.brinkmann@xilinx.com>
 <1393953449-28551-4-git-send-email-soren.brinkmann@xilinx.com>
 <20140304193913.71c6f307@alan.etchedpixels.co.uk>
Message-ID: <201403042316.26221.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, One Thousand Gnomes wrote:
> On Tue,  4 Mar 2014 09:17:26 -0800
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> The following aspects of the change set are IMHO acceptable
> 
> - Cleaning up all the code formatting
> - Update the driver comments and header to explain the Cadence/Xilinx
>   thing
> - change "Xilinx PS UART Support" text to "Cadence (Xilinx PS) Support"
>   or similar wording in Kconfig
> - Adding the cadence devicetree compatibility strings and inputs *in
>   addition* to the existing ones.
> - Documentation for the new options

I agree. I think it would also be nice to allow the standard clock names
to be used as an alternative to the bogus ref_clk" and "aper_clk"
names, but just like the compatible string, it's too late to remove
support for the existing ones.

Regarding the "xlnx,xuartps" compatible string, even if we were to break
backwards comptibility with the clocks, I would still want to see this
string being used in addition to "cdns,uart-r1p8" so we have a way to
detect possible changes that xilinx did on top of the r1p8 version.
I also wonder if "cdns,uart-r1p8" is actually specific enough: r1p8
looks like a version number rather than a name, and it seems possible
that Cadence has produced more than one uart implemention in the past
or will do another one in the future that is not just a different
revision of this one but instead something completely different.

	Arnd
