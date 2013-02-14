From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 16:29:06 -0700
Subject: [v2 1/4] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <20130214.223422.1106350409475384652.hdoyu@nvidia.com>
References: <1360868369-20093-1-git-send-email-hdoyu@nvidia.com><1360868369-20093-2-git-send-email-hdoyu@nvidia.com><511D45E0.1080105@wwwdotorg.org>
 <20130214.223422.1106350409475384652.hdoyu@nvidia.com>
Message-ID: <511D7342.2070205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 01:34 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Thu, 14 Feb 2013 21:15:28 +0100:
> 
>> Oh, and I don't think you updated e.g. nvidia,tegra20-car.txt to remove
>> the list of clocks.
> 
> Not yet removed. I think that this could be done with the patch which
> allows kernel source to include DT header files.

By defining the header file, you're really causing that header to be
part of the binding definition. I think we should move the code from the
binding .txt file to the header, rather than duplicating it and then
removing it. The kernel doesn't include the binding .txt file right now,
so I don't see any correlation with making it include the header vs.
when we remove the list from the binding document.
